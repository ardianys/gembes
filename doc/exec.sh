rails g ardianys_scaffold:scaffold User auth_token:string:index email:string:index name password
rails g ardianys_scaffold:scaffold Team name
rails g ardianys_scaffold:scaffold Stock name
rails g ardianys_scaffold:scaffold Member user:references team:references
rails g ardianys_scaffold:scaffold Wallet creator_id:integer:index who_id:integer:index who_class:string:index code:string:index name:string
rails g ardianys_scaffold:scaffold Transaction from_wallet_id:integer to_wallet_id:integer from_who_id:integer to_who_id:integer from_who_class:string to_who_class:string amount:integer