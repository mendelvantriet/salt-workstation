import json

import salt
from salt.exceptions import CommandExecutionError


def add_ssh_key(name: str, title: str, token: str):
  ret = {"name": name, "result": False, "changes": {}, "comment": ''}
  
  new_key = _read_key_file(name)
  response = _get_ssh_keys(token)
  
  existing_keys = json.loads(response['text'])
  existing_keys = [k['key'] for k in existing_keys]

  if new_key in existing_keys:
    ret['comment'] += 'Key already exists. '
    ret['result'] = True
    return ret
  else:
    ret['comment'] += 'Key not yet exists. '

  response = _post_ssh_key(new_key, title, token)
  if int(response['status']) != 201:
    ret['comment'] += f"Adding key failed with response code {response['status']}"
    return ret

  ret['result'] = True
  ret['comment'] += 'Success adding new key. '
  ret['changes'] = {'old': '', 'new': title}
  return ret


def _read_key_file(path: str):
  with salt.utils.files.fopen(path, 'r') as file_obj:
    return salt.utils.stringutils.to_unicode(file_obj.read()).strip()


def _get_ssh_keys(token: str):
  try:
    return salt.utils.http.query(
      url='https://api.github.com/user/keys',
      header_dict={
        'Accept': 'application/vnd.github+json',
        'Authorization': f'Bearer {token}',
      },
      text=True,
    )
  except Exception as exc:  # pylint: disable=broad-except
    raise CommandExecutionError(str(exc))


def _post_ssh_key(key: str, title: str, token: str):
  try:
    return salt.utils.http.query(
      url='https://api.github.com/user/keys',
      method='POST',
      header_dict={
        'Accept': 'application/vnd.github+json',
        'Authorization': f'Bearer {token}',
      },
      data=json.dumps({'title': title, 'key':  key}),
      status=True,
    )
  except Exception as exc:  # pylint: disable=broad-except
    raise CommandExecutionError(str(exc))

