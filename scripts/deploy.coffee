# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.hear /debug/i, (msg) ->
    msg.send process.env.HUBOT_AUTH_ADMIN 

  robot.hear /deploy auth-server/i, (msg) ->
    
    if robot.auth.hasRole(msg.envelope.user,'deployer')

      msg.send "Kicking off the deploy"
      spawn = require("child_process").spawn
      sh = spawn("sh", ["auth_server.sh"])

      sh.stdout.on "data", (data) ->
        msg.send data.toString()
        return

      sh.stderr.on "data", (data) ->
        msg.send data.toString()
        return

      sh.on "close", (code) ->
        console.log "child process exited with code " + code
        msg.send "exited with code "+ code.toString()
        return
    else
      msg.send "http://i.imgur.com/kgfV66r.gif"
      msg.send "Sorry, You need to have the deployer role."

