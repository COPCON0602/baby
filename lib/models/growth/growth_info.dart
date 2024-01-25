

class GrowthInforRecord {
  DateTime time;
  double weight;
  double height;
  String? note;

  GrowthInforRecord({
    required this.time,
    required this.weight,
    required this.height,
    this.note,
  });

  // Phương thức so sánh dựa trên thời gian
  int compareTo(GrowthInforRecord other) {
    return time.compareTo(other.time);
  }
}
