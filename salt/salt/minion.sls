salt-minion:
  pkg:
    - installed

  file.managed:
    - name: /etc/salt/minion
    - contents: |
        master: localhost
        saltenv: dev

    - require:
      - pkg: salt-minion

  service.running:
    - enable: true
    - require:
      - file: salt-minion
    - watch:
      - pkg: salt-minion
      - file: salt-minion
