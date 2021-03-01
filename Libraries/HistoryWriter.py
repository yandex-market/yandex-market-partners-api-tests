import os


def write_request_to_file(filename: str, url: str, headers: dict, data: str):
    with open(f'{filename}.xml', 'a') as the_file:
        the_file.write('curl ')
        for k in headers:
            the_file.write(f'-H \"{k}: {headers[k]}\" ')

        the_file.write(f'''{url} -d \'
{data}
\'
''')
    return


def write_response_to_file(filename: str, data: str):
    with open(f'{filename}.xml', 'a') as the_file:
        the_file.write(f'''
{data}

========================================================================================================================

''')
    return


def delete_history_file(file_name: str):
    try:
        os.remove(file_name + '.xml')
    except Exception:
        pass