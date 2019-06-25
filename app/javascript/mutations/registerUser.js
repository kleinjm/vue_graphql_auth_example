// app/javascript/mutations/registerUser.js

import gql from 'graphql-tag';

const mutation = gql`
  mutation registerUser(
    $firstName: String!,
    $lastName: String!,
    $email: String!,
    $password: String!,
  ) {
    registerUser(input: {
      firstName: $firstName,
      lastName: $lastName,
      email: $email,
      password: $password,
    }) {
      user {
        id
        firstName
        lastName
        email
        authenticationToken
      }
      success
      errors
    }
  }
`;

export default function({
  apollo,
  firstName,
  lastName,
  email,
  password,
}) {
  return apollo.mutate({
    mutation,
    variables: {
      firstName,
      lastName,
      email,
      password,
    },
  });
}