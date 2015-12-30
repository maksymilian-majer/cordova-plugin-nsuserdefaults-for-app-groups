# NSUserDefaults Plugin for App Groups #
By: Protonet GmbH

Authors: Joschka Schulz

## Adding the Plugin ##

Use the Cordova CLI and type in the following command:

`cordova plugin add https://github.com/protonet/cordova-plugin-nsuserdefaults-for-app-groups.git`

## Description

If you like to share some variables between your main app and an share extension, you need to save your variables in a NSUserDefaults container. The NSUserData container can be shared between your both apps and hold all the data you want to transfer.

Please make sure you add the App Groups in the XCode Project for sharing the container between apps.

## Sample Code

The Plugin is only for iOS.

### Save in UserDefaults

    var options = {
          key: "foo",
          value: "bar",
          suite: "group.cats.catsAreAwesome"};

    window.AppGroupsUserDefaults.save(options,
      function() {
         // success
      }, function() {
        // failed
      });

### Save multiple values at once in UserDefaults

var suite = "group.cats.catsAreAwesome";
var options1 = {
      key: "foo",
      value: "bar"};

var options2 = {
      key: "foo2",
      value: "bar2"};

window.AppGroupsUserDefaults.saveAll(suite, [options1, options2],
  function() {
     // success
  }, function() {
    // failed
  });

### Remove from UserDefaults

var options = {
      key: "foo",
      suite: "group.cats.catsAreAwesome"};

window.AppGroupsUserDefaults.remove(options,
  function() {
     // success
  }, function() {
    // failed
  });

### Remove multiple values at once from UserDefaults

var suite = "group.cats.catsAreAwesome";
var key1 = "foo";
var key2 = "foo2";

window.AppGroupsUserDefaults.removeAll(suite, [key1, key2],
  function() {
     // success
  }, function() {
    // failed
  });

### Load from UserDefaults

    var options = {
          key: "foo",
          suite: "group.cats.catsAreAwesome"};

    window.AppGroupsUserDefaults.load(options,
      function(result) {
       // success
       console.log("Result:", result)
      }, function() {
        // failed
      });
