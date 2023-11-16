salt-master:
  pkg.installed:
    - pkgs:
      - git
      - salt-master

  pip.installed:
    - name: GitPython
    - require:
      - pkg: salt-master

  file.managed:
    - name: /etc/salt/master
    - source: salt://templates/salt/master
    - template: jinja
    - context:
        source: github.com/drlkf/salt-playground
        extensions_dir: /usr/local/lib/salt/extensions
        environments:
          - name: dev
            branch: develop
          - name: stg
            branch: staging
          - name: prd
            branch: master

    - require:
      - pkg: salt-master

  service.running:
    - enable: true
    - require:
      - pip: salt-master
      - file: salt-master
    - watch:
      - pkg: salt-master
      - pip: salt-master
      - file: salt-master

/usr/local/lib/salt:
  file.directory:
    - user: salt
    - group: salt
    - mode: 0755
    - require:
      - pkg: salt-master

/usr/local/lib/salt/extensions:
  file.directory:
    - user: salt
    - group: salt
    - mode: 0755
    - require:
      - file: /usr/local/lib/salt

/usr/local/lib/salt/extensions/pillar:
  file.directory:
    - user: salt
    - group: salt
    - mode: 0755
    - require:
      - file: /usr/local/lib/salt/extensions

/usr/local/lib/salt/extensions/pillar/toto.py:
  file.managed:
    - user: salt
    - group: salt
    - mode: 0444
    - source: salt://extensions/pillar/toto.py
    - require:
      - file: /usr/local/lib/salt/extensions/pillar
    - require_in:
      - service: salt-master
