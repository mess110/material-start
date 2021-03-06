app = angular.module('app', ['ngRoute', 'ngStorage', 'ngMaterial', 'users'])

app.config ['$mdThemingProvider', '$mdIconProvider', ($mdThemingProvider, $mdIconProvider) ->
  $mdIconProvider
    .defaultIconSet('./assets/svg/avatars.svg', 128)
    .icon('menu', './assets/svg/menu.svg', 24)
    .icon('share', './assets/svg/share.svg', 24)
    .icon('google_plus', './assets/svg/google_plus.svg', 512)
    .icon('hangouts', './assets/svg/hangouts.svg', 512)
    .icon('twitter', './assets/svg/twitter.svg', 512)
    .icon('phone', './assets/svg/phone.svg', 512)

  $mdThemingProvider
    .theme('default')
    .primaryPalette('deep-orange')
    .accentPalette('pink')
    .warnPalette('red')
    .backgroundPalette('grey')
    # .dark()

  return
]

app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/users', templateUrl: 'js/users/users.html', controller: 'UserController')
    .otherwise(redirectTo: '/users')
  return
]

app.config(['$localStorageProvider', ($localStorageProvider) ->
  # $localStorageProvider.get('MyKey');
  # $localStorageProvider.set('MyKey', { k: 'value' });

  $localStorageProvider.setKeyPrefix 'app'
  return
])
