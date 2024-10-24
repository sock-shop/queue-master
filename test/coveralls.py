import os
import unittest
from os.path import expanduser

from util.Docker import Docker


class JavaServices(unittest.TestCase):
    def test_maven(self):
        script_dir = os.path.dirname(os.path.realpath(__file__))
        code_dir = script_dir + "/.."
        home = expanduser("~")
        command = ['docker', 'run', '--rm',
                   '-v', home + '/.m2:/root/.m2',
                   '-v', code_dir + ':/usr/src/mymaven',
                   '-w', '/usr/src/mymaven',
                   'maven:3.5.2-jdk-8',
                   'mvn',
                   '-DrepoToken=' + os.getenv('COVERALLS_TOKEN'),
                   'verify',
                   'jacoco:report',
                   'coveralls:report']
        print(Docker().execute(command))


if __name__ == '__main__':
    unittest.main()
