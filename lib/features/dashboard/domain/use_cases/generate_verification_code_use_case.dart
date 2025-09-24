import 'package:my_app/features/dashboard/domain/repositories/request_repository.dart';

class GenerateVerificationCodeUseCase{
  final RequestRepository requestRepository;

  GenerateVerificationCodeUseCase(this.requestRepository);

  Future<bool> execute(int userId){
    return requestRepository.generateVerificationCode(userId);
  }
}