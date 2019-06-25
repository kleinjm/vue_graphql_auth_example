// app/javascript/mutations/signIn.js

import gql from 'graphql-tag';

const mutation = gql`
  mutation signIn($email: String!, $password: String!) {
    signIn(input: { email: $email, password: $password }) {
      user {
        id
        firstName
        lastName
        authenticationToken
      }
      success
      errors
    }
  }
`;

export default function signIn({
  apollo,
  email,
  password,
}) {
  return apollo.mutate({
    mutation,
    variables: {
      email,
      password,
    },
  });
}