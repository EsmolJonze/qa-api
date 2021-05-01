class ReferenceManager:
    def __init__(self):
        self.references = {}

    def __contains__(self, name):
        return self.contains(name)

    def get_id(self, name):
        return self.get_meta_field(name, 'objectId')

    def get_long_id(self, name):
        """Returns the id of the reference that looks like XXXXXX/Lead/YYYYY"""
        return self.get_meta_field(name, 'value')

    def get_bobject_type(self, name):
        return self.get_meta_field(name, 'typeName')

    def get_meta_field(self, name, field):
        bobject = self.references[name]
        if field in bobject:
            return bobject[field]
        elif 'id' in bobject and field in bobject['id']:
            return bobject['id'][field]
        raise KeyError(f"Reference {name} does not have {field}")

    def contains(self, name):
        return name in self.references

    def save(self, name, value):
        self.references[name] = value
