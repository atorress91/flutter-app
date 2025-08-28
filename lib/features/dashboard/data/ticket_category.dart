enum TicketCategory {
  technicalProblem('Problema Técnico'),
  generalInquiry('Consulta General'),
  billingIssue('Problema de Facturación'),
  featureRequest('Solicitud de Característica'),
  reportIssue('Problema con Reporte'),
  other('Otro');

  final String name;
  const TicketCategory(this.name);
}