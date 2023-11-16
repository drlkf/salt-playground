include:
  - .master
  - .minion

/usr/local/bin/salt-test-run:
  file.managed:
    - mode: 0755
    - contents: |
        #!/usr/bin/env bash

        sudo salt-call -l debug pillar.items
        sudo journalctl -u salt-master | less +G
