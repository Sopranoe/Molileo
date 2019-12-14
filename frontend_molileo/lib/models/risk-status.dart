enum RiskStatus { lowRisk, potentialRisk, highRisk, veryHighRisk }

class RiskStatusHelper {
  static String getValue(RiskStatus riskStatus) {
    switch (riskStatus) {
      case RiskStatus.lowRisk:
        return "Low risk";
      case RiskStatus.potentialRisk:
        return "Potential risk";
      case RiskStatus.highRisk:
        return "High risk";
      case RiskStatus.veryHighRisk:
        return "very high risk";
      default:
        return "";
    }
  }
}
