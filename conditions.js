// Generated by CoffeeScript 1.7.1

/* (C) 2014 Narazaka : Licensed under The MIT License - http://narazaka.net/license/MIT?2014 */
var MiyoFilters;

if (typeof MiyoFilters === "undefined" || MiyoFilters === null) {
  MiyoFilters = {};
}

MiyoFilters.conditions = function(argument, request, id, stash) {
  var condition, _i, _len, _ref;
  if (argument.conditions == null) {
    return;
  }
  _ref = argument.conditions;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    condition = _ref[_i];
    if ((!this.has_property(condition, 'when')) || this.property(condition, 'when', request, id, stash)) {
      return this.call_entry(condition["do"], request, id, stash);
    }
  }
};

if ((typeof module !== "undefined" && module !== null) && (module.exports != null)) {
  module.exports = MiyoFilters;
}

//# sourceMappingURL=conditions.map