import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/experience.dart';
import 'package:injectable/injectable.dart';

abstract class ExperienceService {
  Future<Experience> create(Experience experience);
}

@Injectable(as: ExperienceService)
class ExperienceServiceDev extends ExperienceService {
  @override
  Future<Experience> create(Experience experience) async {
    await Future.delayed(const Duration(seconds: 10));
    return Experience.fromJson({
      "id": 1,
      "empresa": experience.enterprise,
      "dataAdmissao": experience.dateAdmission,
      "dataDesligamento": experience.dateFinish,
    });
  }
}
