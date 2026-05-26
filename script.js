const app = document.getElementById('app')
const playerList = document.getElementById('playerList')

window.addEventListener('message', function(event) {

    const data = event.data

    if (data.action === 'open') {

        app.style.display = 'flex'

        loadPlayers(data.players)
    }

    if (data.action === 'showWarning') {

        showWarning(data.reason)
    }

    if (data.action === 'updateProgress') {

        document.getElementById('holdProgress').style.width =
            data.progress + '%'
    }

    if (data.action === 'hideWarning') {

        document.getElementById('warningOverlay').style.display = 'none'
    }
})

function loadPlayers(players) {

    playerList.innerHTML = ''

    players.forEach(player => {

        const div = document.createElement('div')

        div.className = 'player'

        div.innerHTML = `
            <div class="player-name">
                ${player.name} [${player.id}]
            </div>

            <input
                class="reason"
                id="reason-${player.id}"
                placeholder="Voer een reden in"
            >

            <div class="button-row">

                <button class="warn-btn" onclick="warnPlayer(${player.id})">
                    Warn
                </button>

                <button class="kick-btn" onclick="kickPlayer(${player.id})">
                    Kick
                </button>

            </div>

            <div class="button-row second-row">

                <button class="freeze-btn" onclick="toggleFreeze(${player.id})">
                    Freeze
                </button>

                <button class="tp-btn" onclick="gotoPlayer(${player.id})">
                    TP To
                </button>

                <button class="bring-btn" onclick="bringPlayer(${player.id})">
                    Bring
                </button>

            </div>
        `

        playerList.appendChild(div)
    })
}

function warnPlayer(id) {

    const reason = document.getElementById(`reason-${id}`).value

    fetch(`https://${GetParentResourceName()}/warnPlayer`, {
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

function toggleFreeze(id) {

    fetch(`https://${GetParentResourceName()}/toggleFreeze`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: id
        })
    })
}

function gotoPlayer(id) {

    fetch(`https://${GetParentResourceName()}/gotoPlayer`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: id
        })
    })
}

function bringPlayer(id) {

    fetch(`https://${GetParentResourceName()}/bringPlayer`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: id
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

function showWarning(reason) {

    const overlay = document.getElementById('warningOverlay')
    const text = document.getElementById('warningReason')
    const progress = document.getElementById('holdProgress')

    overlay.style.display = 'flex'

    text.innerText = reason || 'Geen reden opgegeven'

    progress.style.width = '0%'
}