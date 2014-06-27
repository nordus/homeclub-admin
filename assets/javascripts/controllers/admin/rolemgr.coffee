define ['s/customeraccount', 's/user', 's/notifier', 's/homeclubadmin', 's/carrieradmin'], ->

  class RoleMgr
    
    @$inject: ['$scope', 'customeraccount', 'user', 'notifier', 'homeclubadmin', 'carrieradmin']


    constructor: (@$scope, @account, @user, @notifier, @homeclubadmin, @carrieradmin) ->


    deleteRole: (userId, role, id) ->

      collection = switch role
        when 'customerAccount' then @account
        when 'homeClubAdmin' then @homeclubadmin
        when 'carrierAdmin' then @carrieradmin

      @user.get id:userId, (user) =>

        console.log 'user:'
        console.log user

        deleteRecordAndAssociation = (record) =>
          console.log record
          return unless confirm("Are you sure you want to delete #{record.name.first} #{record.name.last}")
          record.$delete =>
            delete user.roles[role]
            user.$update =>
              console.log user
              @notifier.success "#{role} Deleted!"

        collection.get id:id, deleteRecordAndAssociation