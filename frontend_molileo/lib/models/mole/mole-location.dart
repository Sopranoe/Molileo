enum MoleLocation { rightArm, leftArm, rightLeg, leftLeg, back, belly, face }

class MoleLocationHelper {
  static String getValue(MoleLocation moleLocation) {
    switch (moleLocation) {
      case MoleLocation.rightArm:
        return "Right arm";
      case MoleLocation.leftArm:
        return "Left arm";
      case MoleLocation.rightLeg:
        return "Right leg";
      case MoleLocation.leftLeg:
        return "Left leg";
      case MoleLocation.back:
        return "back";
      case MoleLocation.belly:
        return "belly";
      case MoleLocation.face:
        return "face";
      default:
        return "";
    }
  }
}
