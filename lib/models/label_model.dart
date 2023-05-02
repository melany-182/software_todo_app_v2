class Label {
  int labelId;
  String name;

  Label({
    this.labelId = 0,
    this.name = '',
  });

  getLabelId() {
    return labelId;
  }

  setLabelId(int labelId) {
    this.labelId = labelId;
  }

  getName() {
    return name;
  }

  setName(String name) {
    this.name = name;
  }

  @override
  String toString() {
    return 'Label{id: $labelId, name: $name}';
  }
}
