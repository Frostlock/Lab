from json import load

class MonsterDB(object):

    @property
    def json(self):
        return self._json

    def __init__(self):
        self._json = None
        with open("monsters.json") as inFile:
            self._json = load(inFile)
        inFile.close()

    def search(self, monsterName):
        if self.json is not None:
            for m in self.json:
                if str(m["name"]).upper() == str(monsterName).upper():
                    return Monster(m)
        return None

class Monster(object):

    @property
    def json(self):
        return self._json

    def __getattr__(self, attribute):
        return self.json[str(attribute).lower()]

    # def __setattr__(self, attr, value):
    #     self[attr] = value

    def __init__(self, json):
        self._json = json

    def __str__(self):
        return self.json["name"] + " [" + self.json["type"] + ":" + self.json["subtype"] + "]"

if __name__ == '__main__':
    mdb = MonsterDB()
    print(mdb.search("kobold"))