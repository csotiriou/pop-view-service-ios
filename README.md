iOS Pop View Service
====================

This library is based on CMPopTipView. It provides a lightweight solution for displaying multiple Pop tip views (bubbles) and automate actions. Ideal for making your own tutorials or presenting information in your applications.

You can present CMPopTipViews in any part of your controller after some time or immediately, and automatically dismiss all visible pop tip views. You can also do this manually. When the controller gets deallocated, it will dismiss all pop tip views, so you won't have to worry about memory management.

CSPopViewService is ideal for making tutorials or demos that show how your application works.

CSPopViewService uses the excellent CMPopTipView class made by Chris Miles, and you can find it here: https://github.com/chrismiles/CMPopTipView