from travelgene import app
import flask_debugtoolbar
from flask_debugtoolbar import DebugToolbarExtension

if __name__ == '__main__':
    app.debug = True
    app.config['SECRET_KEY'] = 'secret_key'
    app.run()
