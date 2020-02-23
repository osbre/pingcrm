describe("Dashboard Index", function() {
  before(function() {
    Cypress.Cookies.debug(true);
    Cypress.Cookies.preserveOnce("_ping_key");
    Cypress.Cookies.preserveOnce("XSRF-TOKEN");
  });

  //   after(function() {
  //     cy.clearCookie("_ping_key");
  //   });

  it("Visits the main page", function() {
    cy.visit("http://localhost:5000/login");
  });

  it("User logs in", function() {
    cy.contains("Welcome Back!");
    cy.get("button[type=submit]").click();
    cy.contains("Dashboard");
    cy.visit("http://localhost:5000/users");
  });
});
