import 'dart:convert';

import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/services/api/base_service.dart';
import 'package:my_app/features/dashboard/domain/entities/balance_information.dart';
import 'package:my_app/core/data/dtos/balance_information_dto.dart';
import 'package:my_app/core/data/mappers/balance_information_mapper.dart';

class WalletService extends BaseService {
  WalletService({super.client}) : super(microservice: Microservice.wallet);

  Future<ApiResponse<BalanceInformation?>> getBalanceInformationByUserId(
    int userId,
  ) async {
    final response = await get('/wallet/GetBalanceInformationByAffiliateId/$userId');

    final Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;

    final initialResponse = ApiResponse<dynamic>.fromEnvelope(
      envelope: body,
      parseData: (json) => json,
      statusCode: response.statusCode,
    );

    if (!initialResponse.success) {
      return ApiResponse<BalanceInformation?>(
        success: false,
        message: initialResponse.message,
        statusCode: initialResponse.statusCode,
        data: null,
      );
    }

    try {
      if (initialResponse.data is Map<String, dynamic>) {
        final balanceDto = BalanceInformationDto.fromJson(
          initialResponse.data as Map<String, dynamic>,
        );
        final balanceEntity = BalanceInformationMapper.fromDto(balanceDto);

        return ApiResponse<BalanceInformation?>(
          success: true,
          data: balanceEntity,
          statusCode: initialResponse.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse<BalanceInformation?>(
        success: false,
        message: 'Error al procesar los datos del balance: $e',
        statusCode: initialResponse.statusCode,
        data: null,
      );
    }

    return ApiResponse<BalanceInformation?>(
      success: false,
      message: 'No se encontraron datos de balance en una respuesta exitosa.',
      statusCode: initialResponse.statusCode,
      data: null,
    );
  }
}
