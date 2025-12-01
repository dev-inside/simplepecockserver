## SPHS (Simple Peacock-Server for Hitman)

SPHS (Simple Peacock-Server for Hitman) is a Docker image for Hitman World of Assassination. The difference in this image is as follows:
- It does not automatically fetch the **"latest"** version of Peacock; instead, the user provides Peacock as a ZIP in the volume. This step may initially seem odd, but it gives you as a Hitman player and self-hoster the following advantages:
  - **The version is not baked into the image**, so you don't have to wait for a new image release.
  - **You can use any Peacock version** — the latest, an older release, or a beta.
- The process is quite simple! Just place the appropriate ZIP (e.g., Peacock-v8.4.0-linux.zip) in the _/your/data/Peacock/version_ volume You can find releases on __Peacock's GitHub__: https://github.com/thepeacockproject/Peacock/releases

## Installation

Let's move on to installation. To run the container it is advisable to prepare your volumes as follows:

```
🖥️ /your/data/Peacock/
├── 📁 version/
│   ├── 📦 Peacock-v8.4.0-linux.zip   ← the Peacock Linux zip you want
├── 📁 userdata/                      ← Content of your userdata folder
│   ├── epicids/
│   ├── h1/
│   ├── h2/
│   ├── scpc/
│   ├── steamids/
│   └── users/
├── 📁 contractSessions/              ← place Contracts here
│   ├── session1.json
│   └── session2.json
└── 📁 plugins/                       ← compatible Peacock plugins (JS files), e.g.:
    ├── KillEveryoneCampaign.plugin.js
    └── another-plugin.plugin.js
```

The server will only start if all volumes are created correctly and the __Peacock-Zip__ is in the right directory! Let's look at the docker-compose.yml with the example "your/data/Peacock".


## docker-compose

```yaml
services:
  peacockserver:
    container_name: PeacockServer
    image: kodemonaut/simplepeacock:latest
    ports:
      - "4700:80"
    volumes:
      - /your/data/Peacock/version:/Peacock/version
      - /your/data/Peacock/userdata:/Peacock/userdata
      - /your/data/Peacock/contractSessions:/Peacock/contractSessions
      - /your/data/Peacock/plugins:/Peacock/plugins
    restart: unless-stopped

```
----

### Powered by the following amazing projects:
- Peacock https://thepeacockproject.org/
- bun.sh https://bun.sh