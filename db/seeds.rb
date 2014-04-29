# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#SiteUsers
user = SiteUser.create! email: 'st.zawadzki@gmail.com', password: 'admin1', password_confirmation: 'admin1', role: 'admin'



#Articles
Article.create! site_user: user, title: 'Lorem ipsum', lead: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultricies condimentum porta. Fusce at magna at dui pulvinar molestie. Quisque pulvinar lectus lacus, ut dignissim nibh placerat ut. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas suscipit congue mi, a vehicula nisi. Nullam lorem libero, auctor vitae tempus a, congue vel urna. Vivamus tempor magna a turpis malesuada, quis hendrerit mi sagittis. In placerat neque eget mauris tincidunt viverra. In vestibulum, ipsum vitae posuere dictum, metus leo bibendum nisi, et lobortis nisl mi quis velit. Aliquam et mattis felis. In vehicula aliquam luctus.
Aliquam eget lacus interdum, tempus augue volutpat, dapibus eros. Nullam ut pellentesque risus. Ut hendrerit tincidunt est ac porta. Vivamus vestibulum tortor vel aliquam congue. Phasellus turpis leo, bibendum in lectus vel, placerat vehicula nunc. Cras volutpat vel massa eget vehicula. Etiam vestibulum, tortor sit amet elementum rhoncus, nulla leo vestibulum nunc, sollicitudin consequat massa lorem vitae metus. Donec ut nibh id urna fringilla faucibus. Nunc convallis nec dolor nec condimentum. Maecenas tortor mauris, molestie ut lacus eget, gravida sollicitudin neque. Pellentesque aliquam quam eu dignissim imperdiet. Aenean volutpat ullamcorper tortor varius lacinia. Aenean vestibulum ligula a venenatis viverra. '

BlogEntry.create! site_user: user, title: 'Lorem ipsum', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultricies condimentum porta. Fusce at magna at dui pulvinar molestie. Quisque pulvinar lectus lacus, ut dignissim nibh placerat ut. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas suscipit congue mi, a vehicula nisi. Nullam lorem libero, auctor vitae tempus a, congue vel urna. Vivamus tempor magna a turpis malesuada, quis hendrerit mi sagittis. In placerat neque eget mauris tincidunt viverra. In vestibulum, ipsum vitae posuere dictum, metus leo bibendum nisi, et lobortis nisl mi quis velit. Aliquam et mattis felis. In vehicula aliquam luctus.'
