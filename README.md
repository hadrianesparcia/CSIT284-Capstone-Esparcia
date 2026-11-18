# Canteen Pre-Order App

**Name:** Esparcia, Hadrian
**Workstation Number:** 25

## Project Description
A Flutter app that lets students pre-order food from the school canteen to skip the line.
Students browse the menu, add items to a cart, place an order using their student ID,
and track the order status (Pending / Ready).

## Core Features
- Menu list (12 dummy items)
- Add to cart (adjust quantities)
- Place order (cash on pickup)
- Order status: Pending / Ready

## Scope Cuts
- Cash-on-pickup only
- Single canteen
- No user accounts (student ID input only)

## Structure
lib/
- main.dart
- screens/ (menu, cart, orders)
- widgets/ (menu item card, status chip)
- models/ (menu item, order)
- data/ (dummy data)
- state/ (in-memory app state)
