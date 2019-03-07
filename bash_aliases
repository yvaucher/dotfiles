alias doco='docker-compose'
alias docor='docker-compose run --rm -p 8888:8069'
alias docu='docker-compose up -d'
alias docl='docker-compose logs'
alias docsh='docker-compose run --rm odoo odoo shell'
alias dood='docker-compose run --rm odoo odoo'
alias docpg='docker-compose run --rm odoo psql'
alias bro='chromium-browser --incognito $(docker-compose port odoo 8069)'

alias docleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
alias docleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

alias g='git'
alias gs='git status'
alias gl='git log -n 10'
alias gri='git rebase --autosquash -i'
alias gfo='git fetch origin; git rebase --autosquash -i origin'

alias ack='ack -s'
