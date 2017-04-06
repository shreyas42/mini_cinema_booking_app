from flask_wtf import Form
from wtforms import StringField,BooleanField
from wtforms.validators import DataRequired
from app.models import Customer
'''
class LoginForm(Form):
	email = TextField("Email",  [Required("Please enter your email address."),Email("Please enter your email address.")])
	password = PasswordField('Password', [Required("Please enter a password.")])
	submit = SubmitField("Sign In")
	def __init__(self, *args, **kwargs):
		Form.__init__(self, *args, **kwargs)
	
	def validate(self):
		if not Form.validate(self):
		return False
	
	user = Customer.query.filter_by(email = self.email.data.lower()).first()
	if user and user.check_password(self.password.data):
		return True
	else:
		self.email.errors.append("Invalid e-mail or password")
		return False
'''