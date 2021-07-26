int getPage(int totalPage, int pageSize) {
  if (totalPage % pageSize == 0) {
    return totalPage ~/ pageSize;
  } else {
    return (totalPage ~/ pageSize) + 1;
  }
}
