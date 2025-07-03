import 'dart:async';

import 'package:web3_ai_assistant/services/web3/web3_service.dart';
import 'package:web3_ai_assistant/services/web3/models/wallet_connection_status.dart';

import 'package:web3_ai_assistant/repositories/wallet/models/wallet_error.dart';
import 'package:web3_ai_assistant/repositories/wallet/models/wallet_state.dart';
import 'package:web3_ai_assistant/repositories/wallet/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  
  WalletRepositoryImpl(this._web3Service) {
    _setupConnectionListener();
  }
  final Web3Service _web3Service;
  final _walletStateController = StreamController<WalletState>.broadcast();
  
  WalletState _currentState = WalletState.initial();
  StreamSubscription<WalletConnectionStatus>? _connectionStatusSubscription;
  
  void _setupConnectionListener() {
    _connectionStatusSubscription = _web3Service.connectionStatusStream.listen(
      _handleConnectionStatusChange,
    );
  }
  
  void _handleConnectionStatusChange(WalletConnectionStatus status) {
    if (status.isConnecting) {
      _updateState(WalletState.loading());
    } else if (status.isConnected && status.walletInfo != null) {
      _updateState(WalletState.connected(status.walletInfo!));
    } else if (status.error != null) {
      _updateState(WalletState.error(status.error!));
    } else {
      _updateState(WalletState.disconnected());
    }
  }
  
  @override
  Stream<WalletState> get walletStateStream => _walletStateController.stream;
  
  @override
  WalletState get currentWalletState => _currentState;
  
  @override
  Future<WalletState> connectWallet() async {
    try {
      _updateState(WalletState.loading());
      
      final status = await _web3Service.connect();
      
      if (status.isConnected && status.walletInfo != null) {
        final state = WalletState.connected(status.walletInfo!);
        _updateState(state);
        return state;
      } else if (status.error != null) {
        final state = WalletState.error(status.error!);
        _updateState(state);
        return state;
      } else {
        throw WalletError.connectionFailed('Unknown error occurred');
      }
    } catch (e) {
      final errorMessage = _parseError(e);
      final state = WalletState.error(errorMessage);
      _updateState(state);
      return state;
    }
  }
  
  @override
  Future<WalletState> disconnectWallet() async {
    try {
      await _web3Service.disconnect();
      final state = WalletState.disconnected();
      _updateState(state);
      return state;
    } catch (e) {
      final errorMessage = _parseError(e);
      final state = WalletState.error(errorMessage);
      _updateState(state);
      return state;
    }
  }
  
  @override
  Future<void> refreshWalletState() async {
    final currentStatus = _web3Service.currentConnectionStatus;
    _handleConnectionStatusChange(currentStatus);
  }
  
  String _parseError(dynamic error) {
    if (error is WalletError) {
      return error.message;
    }
    
    final errorString = error.toString();
    
    if (errorString.contains('User rejected')) {
      return 'Connection cancelled by user';
    } else if (errorString.contains('MetaMask')) {
      return 'MetaMask is not installed or locked';
    } else if (errorString.contains('Network')) {
      return 'Network error. Please check your connection';
    }
    
    return 'An unexpected error occurred: $errorString';
  }
  
  void _updateState(WalletState state) {
    _currentState = state;
    _walletStateController.add(state);
  }
  
  @override
  void dispose() {
    _connectionStatusSubscription?.cancel();
    _walletStateController.close();
  }
}
