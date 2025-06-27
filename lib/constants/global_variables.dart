library;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/msal_auth_service.dart';// /Users/odemi/Documents/Cihan/Flutter/prens/global_variables.dart

final List<String> peopleList = ['Cihan Erdensdfsdfs.', 'Melisa E.'];
final List<String> departmentList= ['Uretim', 'Tuketim','Ilim', 'Bilim','Dilim'];
final List<String> questionList= ['iş yerinde bulunan malzeme, araç-gereç ve belgelerin hepsi gerçekten gerekli mi, yoksa bazıları kaldırılabilir mi?', 
                                  'Gerekli malzemeler kolay erişilebilir, mantıklı bir sırayla ve kullanıcı dostu şekilde yerleştirilmiş mi?',
                                  'Çalışma alanları ve ekipmanlar düzenli olarak temizleniyor mu, temizlikten kimin sorumlu olduğu belli mi?',
                                  'Temizlik, düzen ve sınıflandırma işlemleri için yazılı kurallar, görsel standartlar veya kontrol listeleri mevcut mu?',
                                  '5S uygulamalarının sürekliliğini sağlamak için çalışanlar düzenli olarak bilgilendiriliyor ve denetleniyor mu?'];


late MsalAuthService authService;
final FlutterSecureStorage secureStorage=FlutterSecureStorage();