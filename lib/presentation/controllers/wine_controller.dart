import 'package:get/get.dart';
import '../../domain/entities/wine.dart';
import '../../domain/usecase/get_wines.dart';



class WineController extends GetxController {
  final GetWines getWines;

  var wines = <Wine>[].obs;
  var isLoading = false.obs;

  WineController(this.getWines);

  @override
  void onInit() {
    fetchWines();
    super.onInit();
  }

  void fetchWines() async {
    try {
      isLoading(true);
      wines.value = await getWines();
    } finally {
      isLoading(false);
    }
  }
}
