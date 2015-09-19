do ->

  ###*
  # Main Controller for the Angular Material Starter App
  # @param $scope
  # @param $mdSidenav
  # @param avatarsService
  # @constructor
  ###

  UserController = (userService, $mdSidenav, $mdBottomSheet, $log, $q) ->
    self = this
    # *********************************
    # Internal methods
    # *********************************

    ###*
    # First hide the bottomsheet IF visible, then
    # hide or Show the 'left' sideNav area
    ###

    toggleUsersList = ->
      pending = $mdBottomSheet.hide() or $q.when(true)
      pending.then ->
        $mdSidenav('left').toggle()
        return
      return

    ###*
    # Select the current avatars
    # @param menuId
    ###

    selectUser = (user) ->
      self.selected = if angular.isNumber(user) then $scope.users[user] else user
      self.toggleList()
      return

    ###*
    # Show the bottom sheet
    ###

    showContactOptions = ($event) ->
      user = self.selected

      ###*
      # Bottom Sheet controller for the Avatar Actions
      ###

      ContactPanelController = ($mdBottomSheet) ->
        @user = user
        @actions = [
          {
            name: 'Phone'
            icon: 'phone'
            icon_url: 'assets/svg/phone.svg'
          }
          {
            name: 'Twitter'
            icon: 'twitter'
            icon_url: 'assets/svg/twitter.svg'
          }
          {
            name: 'Google+'
            icon: 'google_plus'
            icon_url: 'assets/svg/google_plus.svg'
          }
          {
            name: 'Hangout'
            icon: 'hangouts'
            icon_url: 'assets/svg/hangouts.svg'
          }
        ]

        @submitContact = (action) ->
          $mdBottomSheet.hide action
          return

        return

      $mdBottomSheet.show(
        parent: angular.element(document.getElementById('content'))
        templateUrl: './users/views/contactSheet.html'
        controller: [
          '$mdBottomSheet'
          ContactPanelController
        ]
        controllerAs: 'cp'
        bindToController: true
        targetEvent: $event).then (clickedItem) ->
        clickedItem and $log.debug(clickedItem.name + ' clicked!')
        return

    self.selected = null
    self.users = []
    self.selectUser = selectUser
    self.toggleList = toggleUsersList
    self.showContactOptions = showContactOptions
    # Load all registered users
    userService.loadAllUsers().then (users) ->
      self.users = [].concat(users)
      self.selected = users[0]
      return
    return

  angular.module('users').controller 'UserController', [
    'userService'
    '$mdSidenav'
    '$mdBottomSheet'
    '$log'
    '$q'
    UserController
  ]
  return
