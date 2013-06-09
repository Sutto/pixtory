// Tweaked from: https://gist.github.com/mattstauffer/3835881
// No guarantees
// 1. include Isotope.js
// 2. include this file
// 3. customize Isotope options at the bottom of this file
// 4. add "margin: 0 auto" to the isotope container

$.Isotope.prototype._getMasonryGutterColumns = function() {
  var gutter = this.options.masonry.gutterWidth || 0;
  containerWidth = this.element.parent().width();
  this.masonry.columnWidth = this.options && this.options.masonry.columnWidth ||
    this.$filteredAtoms.outerWidth(true) ||
    containerWidth;
  this.masonry.columnWidth += gutter;
  this.masonry.cols = Math.floor(containerWidth / this.masonry.columnWidth);
  this.masonry.cols = Math.max(this.masonry.cols, 1);
};

$.Isotope.prototype._masonryReset = function() {
  this.masonry = {};
  this._getMasonryGutterColumns();
  var i = this.masonry.cols;
  this.masonry.colYs = [];
  while (i--) {
    this.masonry.colYs.push( 0 );
  }
};

$.Isotope.prototype._masonryResizeChanged = function() {
  var prevColCount = this.masonry.cols;
  this._getMasonryGutterColumns();
  return ( this.masonry.cols !== prevColCount );
};

$.Isotope.prototype._masonryGetContainerSize = function() {
  var gutter = this.options.masonry.gutterWidth || 0;
  var unusedCols = 0,
    i = this.masonry.cols;
  while ( --i ) {
    if ( this.masonry.colYs[i] !== 0 ) {
      break;
    }
    unusedCols++;
  }
  return {
    height : Math.max.apply( Math, this.masonry.colYs ),
    width : ((this.masonry.cols - unusedCols) * this.masonry.columnWidth) - gutter
  };
};