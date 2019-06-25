// app/javascript/mutations/signOut.js

import gql from 'graphql-tag';

const mutation = gql`
  mutation signOut {
    signOut(input: {}) {
      success
      errors
    }
  }
`;

export default function signOut({ apollo }) {
  return apollo.mutate({ mutation });
}