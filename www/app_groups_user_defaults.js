var AppGroupsUserDefaults = function() {};

AppGroupsUserDefaults.prototype.save = function(options, success, fail) {
  cordova.exec(success ,fail , "AppGroupsUserDefaults", "save", [options]);
};

AppGroupsUserDefaults.prototype.load = function(options, success, fail) {
  cordova.exec(success, fail, "AppGroupsUserDefaults", "load", [options]);
};

AppGroupsUserDefaults.prototype.remove = function(options, success, fail) {
  cordova.exec(success, fail, "AppGroupsUserDefaults", "remove", [options]);
};

AppGroupsUserDefaults.prototype.saveAll = function(suite, options, success, fail) {
  var args = [suite].concat(options);
  cordova.exec(success ,fail , "AppGroupsUserDefaults", "saveAll", args);
};

AppGroupsUserDefaults.prototype.removeAll = function(suite, options, success, fail) {
  var args = [suite].concat(options);
  cordova.exec(success, fail, "AppGroupsUserDefaults", "removeAll", args);
};

var appGroupsUserDefaults = new AppGroupsUserDefaults();
module.exports = appGroupsUserDefaults;
