/// <reference types="cypress" />

describe('Jungle-Project can add to cart', () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('/');
    cy.request('POST', '/login', { email: 'pos99157@gmail.com', password: 'Eun5282' })
      .its('body')
      .as('currentUser');
  })

  it("users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one.", () => {
    const { email, password } = { email: 'pos99157@gmail.com', password: 'Eun5282' };

    cy.visit('/login')
    cy.get('input[name=email]').type(email)
    cy.get('input[name=password]').type(password)

    cy.visit('/');
    cy.get('form').submit();

    cy.get('.nav-link')
      .contains('My Cart (1)');
    // .should('have.text', 'My Cart (1)').click();
  })

});