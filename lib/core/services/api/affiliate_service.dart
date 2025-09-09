import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/users_affiliates_dto.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/data/request/update_image_request.dart';
import 'package:my_app/core/services/api/base_service.dart';

class AffiliateService extends BaseService {
  AffiliateService({super.client}) : super(microservice: Microservice.account);

  Future<ApiResponse<UsersAffiliatesDto?>> updateImage(UpdateImageRequest updateImage) async {
    return put<UsersAffiliatesDto?>(
      '/userAffiliateInfo/update_image/${updateImage.userId}',
      body: updateImage.toJson(),
      fromJson: (json) {
        if (json == null) {
          return null;
        }

        final userPayload =
            (json as Map<String, dynamic>?)?['affiliate'] ??
                json?['user'] ??
                json;

        if (userPayload is Map<String, dynamic>) {
          return UsersAffiliatesDto.fromJson(userPayload);
        }

        throw const FormatException(
          'Payload de usuario no encontrado o con formato incorrecto en la respuesta.',
        );
      },
    );
  }
}