String generateChatRoomId({
  required String uId1,
  required String uId2,
}) {
  List<String> uIds = [uId1, uId2];
  uIds.sort();
  String chatId = uIds.join();
  return chatId;
}
