{% for entry in pillar.mounts.fstab %}

{{ entry.target }}:
  file.directory:
    - dir_mode: 755

fstab-configure-{{ entry.name }}:
  mount.fstab_present:
    - name: {{ entry.name }}
    - fs_file: {{ entry.target }}
    - fs_vfstype: {{ entry.fstype }}
    - fs_mntops: {{ entry.opts }}
    
{% endfor %}

