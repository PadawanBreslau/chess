# -*- encoding : utf-8 -*-
# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Chess::Application.config.secret_key_base = 'aecb3674eb4c419d8afd6681a35dd971aea16d8208f2233c1e9de75bc53942c930db2eb44f6983254645dfada501008e3875469ffb746fdff0a3c82dfc01d956'
