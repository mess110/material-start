MainController = (userService, $mdSidenav, $mdBottomSheet, $log, $q) ->
  self = this

  toggleList = ->
    pending = $mdBottomSheet.hide() or $q.when(true)
    pending.then ->
      $mdSidenav('left').toggle()
      return
    return

  selectUser = (user) ->
    self.selected = if angular.isNumber(user) then $scope.users[user] else user
    self.toggleList()
    return

  showContactOptions = ($event) ->
    user = self.selected

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
      templateUrl: './js/users/contactSheet.html'
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
  self.toggleList = toggleList
  self.showContactOptions = showContactOptions
  # Load all registered users
  userService.loadAllUsers().then (users) ->
    self.users = [].concat(users)
    self.selected = users[0]
    return
  return

angular.module('app').controller 'MainController', ['userService', '$mdSidenav', '$mdBottomSheet', '$log', '$q', MainController]
