class PhotoModal {
  final String webformatURL;

  PhotoModal({
    required this.webformatURL,
  });
  factory PhotoModal.fromMap({required Map data}) {
    return PhotoModal(webformatURL: data['webformatURL']);
  }
}
