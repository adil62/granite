import React from "react";

import { getFromLocalStorage } from "utils/storage";

import NavItem from "./NavItem";

const NavBar = () => {
  const userName = getFromLocalStorage("authUserName");

  return (
    <nav className="shadow bg-white">
      <div className="max-w-7xl mx-auto px-2 sm:px-4 lg:px-8">
        <div className="flex h-16 justify-between">
          <div className="flex px-2 lg:px-0">
            <div className="hidden lg:flex">
              <NavItem name="Todos" path="/dashboard" />
              <NavItem
                iconClass="ri-add-fill"
                name="Add"
                path="/tasks/create"
              />
            </div>
          </div>
          <div className="flex items-center justify-end gap-x-4">
            <span
              className="font-regular transition focus:outline-none inline-flex items-center border-b-2 border-transparent px-2
              pt-1 text-sm leading-5 text-bb-gray-600 text-opacity-50 duration-150 ease-in-out
              focus:text-bb-gray-700"
            >
              {userName}
            </span>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default NavBar;
