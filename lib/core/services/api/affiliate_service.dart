import 'package:my_app/core/config/environments.dart';
import 'package:my_app/core/data/dtos/users_affiliates_dto.dart';
import 'package:my_app/core/data/models/api_response.dart';
import 'package:my_app/core/data/request/update_image_request.dart';
import 'package:my_app/core/data/request/update_user_profile_request.dart';
import 'package:my_app/core/services/api/base_service.dart';

class AffiliateService extends BaseService {
  AffiliateService({super.client}) : super(microservice: Microservice.account);

  Future<ApiResponse<UsersAffiliatesDto?>> updateImage(int userId,UpdateImageRequest updateImage) async {
    return put<UsersAffiliatesDto?>(
      '/userAffiliateInfo/update_image/$userId',
      body: updateImage.toJson(),
      fromJson: (json) {
        if (json == null) {
          return null;
        }

        final jsonMap = json as Map<String, dynamic>?;
        
        final userPayload =
            jsonMap?['affiliate'] ??
                jsonMap?['user'] ??
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

  Future<ApiResponse<UsersAffiliatesDto?>> getAffiliateById(int userId) async{
    return get<UsersAffiliatesDto?>(
        '/userAffiliateInfo/$userId',
        fromJson: (json) {
          if (json is Map<String, dynamic>) {
           return UsersAffiliatesDto.fromJson(json);
          }
          throw Exception('Invalid data format for affiliate');
        }
    );
  }

  Future<ApiResponse<UsersAffiliatesDto?>> updateUserProfile(int userId,UpdateUserProfileRequest user) async{
    return put<UsersAffiliatesDto?>(
      'userAffiliateInfo/update_user_profile/$userId',
      body: user.toJson(),
      fromJson: (json) {
        if (json is Map<String, dynamic>) {
          return UsersAffiliatesDto.fromJson(json);
        }
        throw Exception('Invalid data format for affiliate');
      },
    );
  }
}