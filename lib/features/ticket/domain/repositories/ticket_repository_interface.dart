import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/features/ticket/domain/models/ticket_category_model.dart';
import 'package:sixam_mart_delivery/features/ticket/domain/models/ticket_details_model.dart';
import 'package:sixam_mart_delivery/features/ticket/domain/models/ticket_list_model.dart';
import 'package:sixam_mart_delivery/interface/repository_interface.dart';

abstract class TicketRepositoryInterface implements RepositoryInterface {
  Future<List<Category>?> getTicketCategory();
  Future<bool> createTicket(Map<String, String> data, XFile? image);
  Future<List<Ticket>?> getTicketList(String userType);
  Future<TicketDetailsModel?> getTicketDetails(int? id);
}