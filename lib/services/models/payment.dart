class Payment {
  final String clientName;
  final double amountPaid;
  final String email;
  final String event;
  final String mpesaCode;
  final double totalCost;
  final String Status;
  final String id;

  Payment({
    required this.clientName,
    required this.amountPaid,
    required this.totalCost,
    required this.email,
    required this.event,
    required this.mpesaCode,
    required this.Status,
    required this.id,
    //required int totalCost,
  });

  get status => null;
}
