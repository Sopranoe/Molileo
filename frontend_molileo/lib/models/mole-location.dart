enum MoleLocation {
  rightArm,
  leftArm,
  rightChest,
  leftChest,
  rightLeg,
  leftLeg,
  upperBack,
  lowerBack,
  stomach,
  face
}

class MoleLocationHelper {
  static String getValue(MoleLocation moleLocation) {
    switch (moleLocation) {
      case MoleLocation.rightArm:
        return "Right arm";
      case MoleLocation.leftArm:
        return "Left arm";
      case MoleLocation.rightChest:
        return "Right chest";
      case MoleLocation.leftChest:
        return "Left chest";
      case MoleLocation.rightLeg:
        return "Right leg";
      case MoleLocation.leftLeg:
        return "Left leg";
      case MoleLocation.upperBack:
        return "Upper Back";
      case MoleLocation.lowerBack:
        return "Lower Back";
      case MoleLocation.stomach:
        return "Stomach";
      case MoleLocation.face:
        return "face";
      default:
        return "";
    }
  }

  static MoleLocation toMoleLocation(String moleLocation) {
    switch (moleLocation) {
      case "Right arm":
        return MoleLocation.rightArm;
      case "Left arm":
        return MoleLocation.leftArm;
      case "Right chest":
        return MoleLocation.rightChest;
      case "Left chest":
        return MoleLocation.leftChest;
      case "Right leg":
        return MoleLocation.rightLeg;
      case "Left leg":
        return MoleLocation.leftLeg;
      case "Upper Back":
        return MoleLocation.upperBack;
      case "Lower Back":
        return MoleLocation.lowerBack;
      case "Stomach":
        return MoleLocation.stomach;
      case "face":
        return MoleLocation.face;
      default:
        return null;
    }
  }
}
