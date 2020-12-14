import xmlschema


def xml_validate(data: str, xsd_path: str):
    schema = xmlschema.XMLSchema(xsd_path)
    schema.validate(data)
