// html/script.js

const app = document.getElementById('app')
const playerList = document.getElementById('playerList')

window.addEventListener('message', function(event) {
    const data = event.data

    if (data.action === 'open') {
        app.style.display = 'flex'
        loadPlayers(data.players)
    }
})

function loadPlayers(players) {
    playerList.innerHTML = ''

    players.forEach(player => {
        const div = document.createElement('div')
        div.className = 'player'

        div.innerHTML = `
            <div class="player-name">${player.name} [${player.id}]</div>
            <input class="reason" id="reason-${player.id}" placeholder="Kick reason">
            <button class="kick-btn" onclick="kickPlayer(${player.id})">Kick Player</button>
        `

        playerList.appendChild(div)
    })
}

function kickPlayer(id) {
    const reason = document.getElementById(`reason-${id}`).value

    fetch(`https://${GetParentResourceName()}/kickPlayer`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: id,
            reason: reason
        })
    })
}

function closeMenu() {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST'
    })

    app.style.display = 'none'
}

function searchPlayer() {
    const input = document.getElementById('search').value.toLowerCase()
    const players = document.getElementsByClassName('player')

    for (let i = 0; i < players.length; i++) {
        const text = players[i].innerText.toLowerCase()

        if (text.includes(input)) {
            players[i].style.display = ''
        } else {
            players[i].style.display = 'none'
        }
    }
}
